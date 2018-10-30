require 'semantic_logger'
require 'set'
require 'file-tail'

log = SemanticLogger['main']
filename = File.expand_path('development.log')
SemanticLogger.add_appender(file_name: filename)
SemanticLogger.add_appender(io: $stderr)
buffer = StringIO.new
SemanticLogger.add_appender(io: buffer) #, formatter: :json)
tail_lines =3

log.info 'start'
# puts buffer.string

start = Time.now
last = start
old = -1
duration = 0
puts start
set = Set.new
array = []
top = 2 ** 23
(0...top).each do |i|
  set << i
  # array[i] = i
  now = Time.now
  elapsed = now - last
  if (elapsed > 5) && (now.sec % 5).zero?
    stats = "#{now}: #{format('%.6f', (i / 1e6))}" \
    ", #{format('%.2f', elapsed)}s" \
    ", #{format('%.2f', (now - start))}s" \
    ", #{format('%.6f', ((i - old) / 1e6))}"
    puts stats
    log.info(stats)
    # puts buffer.string
    last = now
    old = i
    # end
    # rubocop: disable Style/Next
    if (now - start > 1800) || (i == top - 1)
      duration = now - start
      stats = "#{now}: #{format('%.6f', (i / 1e6))}" \
    ", #{format('%.2f', duration)}s" \
    ", #{format('%.6f', set.size / 1e6)}" \
    ", #{format('%.6f', array.size / 1e6)}"
      puts stats
      log.info stats
      # puts buffer.string
      break
    end
    # rubocop: enable Style/Next
  end
end
now = Time.now
# last = now
# result = set.classify do |i|
#   here = Time.now
#   if (here - last) > 5 && (here.sec % 5).zero?
#     last = here
#     puts "#{here}:  #{i}"
#   end
#   i % 10
# end
# result.keys.each do |key|
#   puts "#{key}:  #{format('%.6f', result[key].size / 1e6)}"
# end
puts format('%.6f', (set.size / 1e6)), format('%.6f', (array.size / 1e6))
puts format('%.2fs', duration)
puts format('%.2fs', (Time.now - now))
puts format('%.2fs', (Time.now - start))

log.info('finish', set_size: set.size / 1e6, load: duration, analyze: Time.now - now, total: Time.now - start)
SemanticLogger.flush
puts '*****FILE*****'
File.open(filename) do |aLog|
  aLog.extend(File::Tail)
  puts aLog.backward(tail_lines).tail(tail_lines)
end
puts '*****BUFFER*****'
puts buffer.string
# sleep(1)
puts '*****FILE*****'
File.open(filename) do |aLog|
  aLog.extend(File::Tail)
  puts aLog.backward(tail_lines).tail(tail_lines)
end