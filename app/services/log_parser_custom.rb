module LogParserCustom
    class << self
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