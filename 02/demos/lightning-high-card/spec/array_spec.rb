#Describe an it syntax explained in classes

class ExampleGroup
  def self.it(desc, &block)
    define_method(desc, &block)
    @examples ||= []
    @examples << desc
  end

  def self.examples
    @examples
  end
end

class ArraySpec < ExampleGroup
  def build_array(*args)
   [*args]
  end

  it 'has a length'do
    raise unless build_array("a").length == 1
  end

  it 'has a first element' do

    # fake failure
    raise "fail"

    raise unless build_array("a").first == "a"
  end
# create a new instance and call the example method
  ArraySpec.examples.each do |example|
    #.send is a ruby built-in to dynamycally calling a method
    begin
      ArraySpec.new.send(example)
      puts"#{example}: PASS"
    rescue => e
      puts "#{example}: FAIL (#{e.message})"
    end
  end
end
