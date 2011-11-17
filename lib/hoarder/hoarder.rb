module Hoarder
  class Hoarder

    def initialize(storage)
      @storage = storage 
    end

    def file_name(file, path)
      relative_path(path).empty? ? File.basename(file) : "#{relative_path(path)}/#{File.basename(file)}"
    end

    def hidden_file?(file_name)
      file_name.chr == '.' ? true : false 
    end

    def hoard(path)
      current_path = relative_path(path).empty? ? @storage.absolute_path : "#{@storage.absolute_path}/#{relative_path(path)}"
      Dir.new(path).each do |f|
        unless ignore_file?(f)
          begin
            if File.directory?("#{current_path}/#{f}") 
              puts "Creating directory #{File.basename(f)}"
              @storage.locker.files.create(
                :key => file_name(f, path),
                :body => '',
                :content_type => 'application/directory',
                :public => @storage.public
              )
              self.send "hoard", "#{path}/#{File.basename(f)}"
            else
              unless File.basename(f) == "hoarder.yml"
                puts "Creating file #{File.basename(f)}"
                @storage.locker.files.create(
                  :key => file_name(f, path),
                  :body => File.open("#{current_path}/#{f}"),
                  :public => @storage.public
                )
              end
            end
          rescue
            puts "Error creating file #{file_name(f, path)}"
          end
        end
      end
    end

    def ignore_file?(file)
      ['.', '..'].include?(File.basename(file)) || hidden_file?(File.basename(file)) ? true : false 
    end

    def relative_path(path)
      path.split('/').slice(@storage.absolute_path.split('/').size..path.split('/').size).join('/')
    end
    private :relative_path

  end
end
