require 'spec_helper'
describe Admin::CategoriesController, type: :controller do
  let(:mime) { Mime::Type.lookup_by_extension(:edn) }

  let(:filename) do
    "categories-#{Time.now.strftime('%Y-%m-%d')}.edn"
  end

  it 'generates an edn filename' do
    expect(controller.edn_filename).to eq(filename)
  end

  context 'when making requests with the edn mime type' do
    it 'returns edn attachment when requested' do
      request.accept = mime
      get :index
      disposition = "attachment; filename=\"#{filename}\""
      expect(response.headers['Content-Disposition']).to start_with(disposition)
      expect(response.headers['Content-Transfer-Encoding']).to eq('binary')
    end
  end
end
