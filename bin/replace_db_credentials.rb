def generateConnectionString()
  "url: postgresql://"+
      ENV["POSTGRES_USER_NAME"].to_s+":"+ENV["POSTGRES_PASSWORD"].to_s+"@"+
      ENV["POSTGRES_HOST"].to_s+":5432/open_lmis"
end

def generateModelPath()
  "models_directory:" + ENV["MODELS_PATH"].to_s
end

def generateLogPath()
  "log : " + ENV["LOGS_PATH"].to_s
end

def generateCubePath()
  ENV["CUBES_PATH"].to_s
end

lines=File.readlines(generateCubePath+'/slicer.ini')
linesWithCredentials=lines.map { |line|

  if line["url"]
    puts "replacing sql connection string"
    generateConnectionString
  elsif line["models_directory"]
    puts "replacing model path"
    generateModelPath
  elsif line["log :"]
    puts "replacing log path"
    generateLogPath
  else
    line
  end
}

File.open(generateCubePath+'/slicer.ini', "w+") do |f|
  linesWithCredentials.each { |element| f.puts(element) }
end
