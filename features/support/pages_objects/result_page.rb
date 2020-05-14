class Home < SitePrism::Page
  set_url ''

  section :results_page, 'main#main-content' do
    elements :heading, 'h1'
    element :estimated_cost, 'h2 > span'
  end

  section :procure_page, 'div.govuk-body' do
    element :header, 'h1'
  end
end