
def scenario_zero_framework(uom, rate, building_occupants, tupe, london_location, cafm, helpdesk, procurement_year)


  sub_year = procurement_year - 1
  uom_deliverables = rate * uom
  cleaning_consumables = if building_occupants > 0
                           building_occupants *  TEST_DATA.by_row[153]['framework'].to_f
                         elsif building_occupants == 0
                           0
                         end
  subtotal_one = uom_deliverables + cleaning_consumables
  london_variance = if london_location == 'Yes'
                      subtotal_one * (TEST_DATA.by_row[151]['framework'] * 100).to_f
                    elsif london_location == 'No'
                      0
                    end
  subtotal_two = subtotal_one + london_variance
  cafm_total = if cafm == 'Yes'
                 subtotal_two * TEST_DATA.by_row[144]['framework'].to_f
               elsif cafm == 'No'
                 0
               end

  helpdesk_total = if helpdesk == 'Yes'
                     subtotal_two * TEST_DATA.by_row[145]['framework'].to_f
                     elsif helpdesk == 'No'
                     0
                   end

  subtotal_three = subtotal_two + cafm_total + helpdesk_total
  mobilisation_cost = subtotal_three * 0
  tupe_cost = if tupe == 'Yes'
                subtotal_three * (TEST_DATA.by_row[152]['framework'] * 100).to_f
              elsif tupe == 'None'
                0
              end
  year_one_deliverable = subtotal_three + mobilisation_cost + tupe_cost
  management_cost = year_one_deliverable * (TEST_DATA.by_row[148]['framework'] * 100).to_f
  corporate_cost = year_one_deliverable * (TEST_DATA.by_row[149]['framework'] * 100).to_f
  year_one_subtotal = year_one_deliverable + management_cost + corporate_cost
  profit_cost = year_one_deliverable * (TEST_DATA.by_row[150]['framework'] * 100).to_f
  year_one_total_charges = year_one_subtotal + profit_cost
  sub_year_total = sub_year * (year_one_total_charges - ((mobilisation_cost + (mobilisation_cost * (TEST_DATA.by_row[148]['framework'] * 100).to_f) + (mobilisation_cost * (TEST_DATA.by_row[149]['framework'] * 100).to_f)) * ((TEST_DATA.by_row[150]['framework'] * 100).to_f + 1)))
  sub_year_total + year_one_total_charges
end



def scenario_zero_benchmark(uom, rate, building_occupants, tupe, london_location, cafm, helpdesk,  procurement_year)
  sub_year = procurement_year - 1

  uom_deliverables = rate * uom
  cleaning_consumables = building_occupants *  TEST_DATA.by_row[153]['benchmark'].to_f
  subtotal_one = uom_deliverables + cleaning_consumables
  london_variance = if london_location == 'Yes'
                      subtotal_one * (TEST_DATA.by_row[151]['benchmark'] * 100).to_f
                    elsif london_location == 'No'
                      0
                    end
  subtotal_two = subtotal_one + london_variance
  cafm_total = if cafm == 'Yes'
                 subtotal_two * TEST_DATA.by_row[144]['benchmark'].to_f
               elsif cafm == 'No'
                 0
               end
  helpdesk_total = if helpdesk == 'Yes'
                     subtotal_two * TEST_DATA.by_row[145]['benchmark'].to_f
                   elsif helpdesk == 'No'
                     0
                   end
  subtotal_three = subtotal_two + cafm_total + helpdesk_total
  mobilisation_cost = subtotal_three * (TEST_DATA.by_row[143]['benchmark'] * 100).to_f
  tupe_cost = if tupe == 'Yes'
                subtotal_three * (TEST_DATA.by_row[152]['benchmark'] * 100).to_f
                elsif tupe == 'None'
                0
              end

  year_one_deliverable = subtotal_three + mobilisation_cost + tupe_cost
  management_cost = year_one_deliverable * (TEST_DATA.by_row[148]['benchmark'] * 100).to_f
  corporate_cost = year_one_deliverable * (TEST_DATA.by_row[149]['benchmark'] * 100).to_f
  year_one_subtotal = year_one_deliverable + management_cost + corporate_cost
  profit_cost = year_one_deliverable * (TEST_DATA.by_row[150]['benchmark'] * 100).to_f
  year_one_total_charges = year_one_subtotal + profit_cost
  sub_year_total = sub_year * (year_one_total_charges - ((mobilisation_cost + (mobilisation_cost * (TEST_DATA.by_row[148]['benchmark'] * 100).to_f) + (mobilisation_cost * (TEST_DATA.by_row[149]['benchmark'] * 100).to_f)) * ((TEST_DATA.by_row[150]['benchmark'] * 100).to_f + 1)))
  sub_year_total + year_one_total_charges

end


def buyer_input_total(estimated_cost, procurement_year)
  estimated_cost * procurement_year
end


def assessed_value_with_cost(uom_total, buyer_input, benchmark_costs)
  if buyer_input == 0
    (uom_total + benchmark_costs) / 2
    else buyer_input > 0
    (uom_total + benchmark_costs + buyer_input) / 3
  end
end

def variance_service_missing(uom_total, buyer_input, benchmark_costs)
  avg_1 = [buyer_input, benchmark_costs]
  avg_2 = [benchmark_costs, buyer_input]

  variance = ((((avg_1.sum(0.0)/ avg_1.size) - uom_total)/(avg_2.sum(0.0)/avg_2.size)) * 100)


    if (variance > -30 && variance < 30)
      (uom_total + benchmark_costs + buyer_input)/3
    elsif (variance < -30 || variance > 30)
      (benchmark_costs + buyer_input)/2
    else
      return 0
    end

end