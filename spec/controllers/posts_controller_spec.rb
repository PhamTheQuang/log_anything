require 'rails_helper'

describe PostsController do
  let(:user) { FactoryGirl.create(:user) }

  describe 'create POST' do
    let(:title) { Faker::Lorem.sentence }
    let(:content) { Faker::Lorem.paragraph }
    let(:result) { post :create, params }

    context 'user auth is invalid' do      
      let(:params) do
        {
          user_id: user.id,
          log_token: 'invalid token',
          title: title,
          content: content
        } 
      end

      it 'does not create post for user' do
        expect{ result }.not_to change(Post, :count)
      end
    end

    context 'user auth is valid' do
      let(:params) do
        {
          user_id: user.id,
          log_token: user.log_token,
          title: title,
          content: content        
        }
      end

      it 'creates post for user' do
        expect{ result }.to change(Post, :count).by(1)
        expect(Post.last.title).to eq title
        expect(Post.last.content).to eq content
      end
    end

    context 'duplicate unique id' do
      let!(:existed_post) { FactoryGirl.create(:post, user: user, unique_id: existed_unique_id) }
      let(:existed_unique_id) { 'existed' }      
      let(:params) do
        {
          user_id: user.id,
          log_token: user.log_token,
          title: title,
          content: content,
          unique_id: existed_unique_id
        }
      end

      it 'does not create post for user' do
        expect{ result }.not_to change(Post, :count)
      end
    end
  end
end