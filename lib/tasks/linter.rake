# frozen_string_literal: true

namespace :lint do
  desc 'Run RuboCop with auto-correction'

  task rubocop: :environment do
    puts 'Running RuboCop with auto-correction...'
    system('rubocop -A')
  end
end
