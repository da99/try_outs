

CACHE = {}
class Symbol
  def to_html_attr
    CACHE[self] ||= begin
                      puts "creating..."
                      str = to_s.gsub(/[^a-z0-9\_]/, '')
                      if str.empty?
                        "Invalid: #{self.inspect}" 
                      else
                        str
                      end
                    end
  end
end


puts :help.to_html_attr
puts :"eret$$".to_html_attr
puts :"#%**$".to_html_attr




puts :help.to_html_attr
puts :"eret$$".to_html_attr
puts :"#%**$".to_html_attr
