module Uploader
  private

  # See https://github.com/carrierwaveuploader/carrierwave/wiki/How-to%3A-Create-random-and-unique-filenames-for-all-versioned-files
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
