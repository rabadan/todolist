require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:model) { FactoryBot.create(:task, text: 'test task 1') }

  describe '.create' do
    it 'correct' do
      expect(model.text).to eq 'test task 1'
    end
  end
end
