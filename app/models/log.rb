class Log < ApplicationRecord
    has_one_attached :file

    # def log_file_path
    #     ActiveStorage::Blob.service.path_for(file.key)
    # end
end
