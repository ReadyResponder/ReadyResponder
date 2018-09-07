require 'rails_helper'

RSpec.describe AnalyticsController, type: :controller do
  describe 'GET system_activity_logs' do
    it 'renders the correct template' do
      get :system_activity_logs
      expect(response).to render_template(:system_activity_logs)
    end

    context 'when no filters have been provided' do
      before { get :system_activity_logs }

      it 'assigns ivars correctly' do
        expect(assigns(:date)).to eq(nil)
        expect(assigns(:category)).to eq(nil)
        expect(assigns(:logs)).to eq(SystemActivityLog.all)
      end
    end

    context 'when some log records exist' do
      let(:day) { 10 }
      let(:month) { 10 }
      let(:year) { 2010 }
      let(:date) { Date.new(year, month, day) }
      let(:category) { "Item" }

      before do
        SystemActivityLog.create!(
          user: User.first,
          message: "test",
          category: "Item",
          created_at: date
        )

        SystemActivityLog.create!(
          user: User.first,
          message: "test",
          category: "Location",
          created_at: Date.new(2011, 11, 11)
        )
      end

      context 'when the date filter has been provided' do
        before do
          get :system_activity_logs, params:
            { date:
              {
                "year" => year,
                "month" => month,
                "day" => day
              }
            }
        end

        it 'assigns ivars correctly' do
          date = Date.new(year, month, day)

          expect(assigns(:date)).to eq(date)
          expect(assigns(:category)).to eq(nil)
          expect(assigns(:logs)).to eq(SystemActivityLog.on_date(date))
        end
      end

      context 'when the category filter has been provided' do
        before do
          get :system_activity_logs, params: { category: category }
        end

        it 'assigns ivars correctly' do
          expect(assigns(:date)).to eq(nil)
          expect(assigns(:category)).to eq(category)
          expect(assigns(:logs)).to eq(SystemActivityLog.for_category(category))
        end
      end

      context 'when both filters have been provided' do
        before do
          get :system_activity_logs, params:
            { date:
              {
                "year" => year,
                "month" => month,
                "day" => day
              },
              category: category
            }
        end

        it 'assigns ivars correctly' do
          expect(assigns(:date)).to eq(date)
          expect(assigns(:category)).to eq(category)
          expect(assigns(:logs)).to eq(
            SystemActivityLog.on_date(date).for_category(category)
          )
        end
      end
    end
  end
end
