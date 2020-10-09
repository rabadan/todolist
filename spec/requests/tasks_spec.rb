 require 'rails_helper'

RSpec.describe "/tasks", type: :request do
  # Task. As you add validations to Task, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { text: 'TASK 1' }
  }

  let(:invalid_attributes) {
    { name: 'TASK 1' }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Task.create! valid_attributes
      get tasks_url
      expect(response).to be_successful
    end
  end


  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Task" do
        expect {
          post tasks_url, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the created task" do
        post tasks_url, params: { task: valid_attributes }
        expect(response).to redirect_to(tasks_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post tasks_url, params: { task: invalid_attributes }
        }.to change(Task, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post tasks_url, params: { task: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    let(:task) { FactoryBot.create(:task, text: 'test task 1') }
    context "with valid parameters" do
      it "close task" do
        patch task_url(task), params: { is_closed: '1' }
        task.reload
        expect(task.is_closed).to be_truthy
      end

      it "return a closed task" do
        patch task_url(task), params: { is_closed: '0' }
        task.reload
        expect(task.is_closed).to be_falsey
      end

      it "redirects to the task" do
        patch task_url(task), params: { is_closed: '1' }
        task.reload
        expect(response).to redirect_to(tasks_path)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete task_url(task)
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      task = Task.create! valid_attributes
      delete task_url(task)
      expect(response).to redirect_to(tasks_url)
    end
  end
end
