# writing an acceptance test that as much as possible, pretends to be a user
# user-interface == command line

require 'pty'
# we have to launch te game, send an input and verify if we won
BIN = 'File.expand_path("../../bin/play", __FILE__)'

describe 'CLI' do
  #the example keyword == alias for 'it'
  #launches a process and gives control over in- and output streams.
  example 'it works' do
    #using PTY class to Test Interactive CLI APPS
    PTY.spawn(BIN) do |output, input, pid|
      sleep 0.5

      input.write("y\n")

      sleep 0.5

      buffer = output.read_nonblock(1024)
      raise unless buffer.include?("You won") || buffer.include?("You lost")
    end
  end
end


