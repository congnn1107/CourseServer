class SaveFileService
  include Interactor

  def call
    file = context.file
    blob = ActiveStorage::Blob.create_and_upload!(io: File.open(file), filename: file.original_filename)
    context.result = blob

    context.fail!(message: "Can not save this file!") unless blob
  end
end
