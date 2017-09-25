
#
# Checks if there are any that need to be updated based on the contents of Carthage.resolved
# If any currently build library (located in Carthage/Build) is of a different version
# than in the Carthage.resolved file (or does not exist) it will be updated.
#

require 'json'

class Bootstrapper

  BASE_DIR = File.dirname(File.expand_path(File.dirname(__FILE__)))

  def run
    carthage_exist = Dir.exist?(File.join(BASE_DIR, "Carthage"))

    if carthage_exist
      outdated = find_outdated_libs
      unless outdated.empty?
        bootstrap(libs: outdated)
      else
        puts "All dependencies are up to date."
      end
    else
      # carthage bootstrap has not been run yet so run it without specifying any libs
      bootstrap
    end
  end

  def find_outdated_libs
    resolved_hash.reduce([]) do |res, pair|
      lib_name = pair.first
      resolved_version = pair.last
      existing_version = existing_hash[lib_name]

      if resolved_version != existing_version
        res << lib_name
      end

      res
    end
  end

  def bootstrap(libs: [])
    puts "Updating dependencies:"
    cmd = "carthage bootstrap #{libs.join(" ")} --platform iOS --no-use-binaries"
    puts cmd
    puts system(cmd)
  end

  def resolved_hash
    File.readlines(File.join(BASE_DIR, "Cartfile.resolved"))
      .reduce({}) do |hash, line|
        name, version = parse_line(line)
        hash[name] = version
        hash
      end
  end

  def parse_line(resolved_line)
    match = /.+?\s"(.+?)"\s"(.+?)"/.match(resolved_line)
    name = match[1].split("/").last.sub(".git", "")  # isolate lib name
    version = match[2]
    [name, version]
  end

  def existing_hash
    build_dir = File.join(BASE_DIR, "Carthage", "Build")
    version_files = Dir.glob(File.join(build_dir, "*.version"), File::FNM_DOTMATCH)

    version_files
      .map do |path|
        [lib_name_from_path(path), JSON.parse(File.read(path))]
      end
      .reduce({}) do |hash, file|
        name, json = file
        hash[name] = json["commitish"]
        hash
      end
  end

  def lib_name_from_path(path)
    path[/Carthage\/Build\/\.(.+?)\.version/, 1]
  end
end

Bootstrapper.new.run
