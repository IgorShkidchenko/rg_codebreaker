# frozen_string_literal: true

module Uploader
  PATH_FOLDER = './data_base/'
  PATH_NAME = 'database'
  PATH_FORMAT = '.yaml'
  PATH = PATH_FOLDER + PATH_NAME + PATH_FORMAT

  def load_db
    YAML.load_stream(File.open(PATH))
  end

  def sort_db
    load_db.sort_by { |user| [user.all_attempts, -user.left_attempts, -user.left_hints] }
  end

  def save_to_db(results)
    File.open(PATH, 'a') { |f| f.write results.to_yaml }
  end
end
