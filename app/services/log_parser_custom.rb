module LogParserCustom
    class << self

        def parser(raw_data, params_search)
            result_parses = []
            path_blob = ActiveStorage::Blob.service.path_for(raw_data.file.key)
            apache_regex = /(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}) - (.{0})- \[([^\]]+?)\] "(GET|POST|PUT|DELETE) ([^\s]+?) (HTTP\/1\.1)" (\d+) (\d+) ([^\s]+?) "(.*)"/

            file = File.foreach(path_blob)
            file.each_entry do |line|
                parser = line.scan(apache_regex)[0]

                if line.scan(apache_regex)[0].nil?
                    puts "Can't parser: #{line}\n\n"
                    next
                end

                parse = {
                    :ip         => parser[0],
                    :user       => parser[1],
                    :time       => parser[2],
                    :method     => parser[3],
                    :uri_path   => parser[4],
                    :protocol   => parser[5],
                    :code       => parser[6],
                    :res_size   => parser[7],
                    :referer    => parser[8],
                    :user_agent => parser[9]
                }

                result_parses << parse if self.search(parse, params_search)
            end
            return result_parses
        end

        def search(parse, params_search)
            valid = true
            params_search.each do |key, value|
                if parse[key.to_sym] && value.present?
                    if !parse[key.to_sym].include?(params_search[key.to_sym])
                        valid = false
                    end
                end
                break if !valid
            end

            return valid
        end
    end
end

#TODO search by time must convert to integer to be more easier