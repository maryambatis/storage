class Blob < ApplicationRecord
  validates :key, uniqueness: true
  enum service_type: {
    sftp: 0,
    s3: 1
  }
end
