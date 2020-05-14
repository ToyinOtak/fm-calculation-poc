Given(/^I am a logged in user$/) do
  visit '/sign-in'
  sign_in()
end

When(/^I click on "(.+)"$/) do |text|
  click_on text
end

And(/^I am on the "(.+)"$/) do |header|
  expect(home.procure_page.header.text).to eq(header)
end

And(/^I am on the results page$/) do
  expect(home.results_page.heading[0].text).to end_with('Results')
end

Then(/^I should see assessed value price for scenario zero$/) do
  # (uom, rate, building_occupants, tupe, london_location, cafm, helpdesk,  procurement_year)

  mechanical_framework = scenario_zero_framework(63200, TEST_DATA.by_row[0]['framework'].to_f, 0, 'None', "No", "No", "No", 2 )
  routine_cleaning_framework = scenario_zero_framework(63200, TEST_DATA.by_row[69]['framework'].to_f, 34, 'None', "No", "No", "No", 2 )
  reception_service_framework = scenario_zero_framework(6240, TEST_DATA.by_row[109]['framework'].to_f, 0, 'None', "No", "No", "No", 2 )
  general_waste_framework = scenario_zero_framework(130, TEST_DATA.by_row[125]['framework'].to_f, 0, 'None', "No", "No", "No", 2 )
  mechanical_benchmark = scenario_zero_benchmark(63200, TEST_DATA.by_row[0]['benchmark'].to_f, 0, 'None', "No", "No", "No", 2 )
  routine_cleaning_benchmark = scenario_zero_benchmark(63200, TEST_DATA.by_row[69]['benchmark'].to_f, 34, 'None', "No", "No", "No", 2 )
  reception_service_benchmark = scenario_zero_benchmark(6240, TEST_DATA.by_row[109]['benchmark'].to_f, 0, 'None', "No", "No", "No", 2 )
  general_waste_benchmark = scenario_zero_benchmark(130, TEST_DATA.by_row[125]['benchmark'].to_f, 0, 'None', "No", "No", "No", 2 )

  uom_total_deliverable = mechanical_framework + routine_cleaning_framework + reception_service_framework + general_waste_framework
  benchmark_cost = mechanical_benchmark + routine_cleaning_benchmark + reception_service_benchmark + general_waste_benchmark
  buyer_input = buyer_input_total(500000, 2)

  assess_value = assessed_value_with_cost(uom_total_deliverable, buyer_input, benchmark_cost)


  result_value = home.results_page.estimated_cost.text.delete(',')
  expect(result_value).to eq("£#{assess_value.round}")

end

Then(/^I should see assessed value price for scenario zero b$/) do
  # (uom, rate, building_occupants, tupe, london_location, cafm, helpdesk,  procurement_year)

  mechanical_framework = scenario_zero_framework(63200, TEST_DATA.by_row[0]['framework'].to_f, 0, 'Yes', "Yes", "Yes", "Yes", 2 )
  routine_cleaning_framework = scenario_zero_framework(63200, TEST_DATA.by_row[69]['framework'].to_f, 34, 'Yes', "Yes", "Yes", "Yes", 2 )
  reception_service_framework = scenario_zero_framework(6240, TEST_DATA.by_row[109]['framework'].to_f, 0, 'Yes', "Yes", "Yes", "Yes", 2 )
  general_waste_framework = scenario_zero_framework(130, TEST_DATA.by_row[125]['framework'].to_f, 0, 'Yes', "Yes", "Yes", "Yes", 2 )
  mechanical_benchmark = scenario_zero_benchmark(63200, TEST_DATA.by_row[0]['benchmark'].to_f, 0, 'Yes', "Yes", "Yes", "Yes", 2 )
  routine_cleaning_benchmark = scenario_zero_benchmark(63200, TEST_DATA.by_row[69]['benchmark'].to_f, 34, 'Yes', "Yes", "Yes", "Yes", 2 )
  reception_service_benchmark = scenario_zero_benchmark(6240, TEST_DATA.by_row[109]['benchmark'].to_f, 0, 'Yes', "Yes", "Yes", "Yes", 2 )
  general_waste_benchmark = scenario_zero_benchmark(130, TEST_DATA.by_row[125]['benchmark'].to_f, 0, 'Yes', "Yes", "Yes", "Yes", 2 )

  uom_total_deliverable = mechanical_framework + routine_cleaning_framework + reception_service_framework + general_waste_framework
  benchmark_cost = mechanical_benchmark + routine_cleaning_benchmark + reception_service_benchmark + general_waste_benchmark
  buyer_input = buyer_input_total(500000, 2)

  assess_value = assessed_value_with_cost(uom_total_deliverable, buyer_input, benchmark_cost)

  puts assess_value

end


Then(/^I should see assessed value price for scenario one$/) do
  # (uom, rate, building_occupants, tupe, london_location, cafm, helpdesk,  procurement_year)


  mechanical_framework = scenario_zero_framework(63200, TEST_DATA.by_row[0]['framework'].to_f, 0, 'None', "No", "No", "No", 1 )
  locksmith_framework = scenario_zero_framework(63200, 0, 0, 'None', "No", "No", "No", 1)
  routine_cleaning_framework = scenario_zero_framework(63200, TEST_DATA.by_row[69]['framework'].to_f, 34, 'None', "No", "No", "No", 1 )
  reception_service_framework = scenario_zero_framework(6240, TEST_DATA.by_row[109]['framework'].to_f, 0, 'None', "No", "No", "No", 1 )
  general_waste_framework = scenario_zero_framework(130, TEST_DATA.by_row[125]['framework'].to_f, 0, 'None', "No", "No", "No", 1 )
  mechanical_benchmark = scenario_zero_benchmark(63200, TEST_DATA.by_row[0]['benchmark'].to_f, 0, 'None', "No", "No", "No", 1 )
  locksmith_benchmark = scenario_zero_benchmark(63200, TEST_DATA.by_row[41]['benchmark'].to_f, 0, 'None', "No", "No", "No", 1)
  routine_cleaning_benchmark = scenario_zero_benchmark(63200, TEST_DATA.by_row[69]['benchmark'].to_f, 34, 'None', "No", "No", "No", 1 )
  reception_service_benchmark = scenario_zero_benchmark(6240, TEST_DATA.by_row[109]['benchmark'].to_f, 0, 'None', "No", "No", "No", 1 )
  general_waste_benchmark = scenario_zero_benchmark(130, TEST_DATA.by_row[125]['benchmark'].to_f, 0, 'None', "No", "No", "No", 1 )

  uom_total_deliverable = mechanical_framework + locksmith_framework + routine_cleaning_framework + reception_service_framework + general_waste_framework
  benchmark_cost = mechanical_benchmark + locksmith_benchmark + routine_cleaning_benchmark + reception_service_benchmark + general_waste_benchmark
  buyer_input = buyer_input_total(1412100, 1)


  assess_value = variance_service_missing(uom_total_deliverable, buyer_input, benchmark_cost)

  result_value = home.results_page.estimated_cost.text.delete(',')
  expect(result_value).to eq("£#{assess_value.round}")

end


