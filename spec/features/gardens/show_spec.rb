require 'rails_helper'

RSpec.describe 'gardens show page' do
  it 'lists unique plants with less than 100 days to harvest in this gardens plots' do
    garden = Garden.create!(name: 'Turing Community Garden', organic: true)
    plot1 = garden.plots.create!(number: 1, size: 'Large', direction: 'East')
    plot2 = garden.plots.create!(number: 2, size: 'Medium', direction: 'West')
    plot3 = garden.plots.create!(number: 3, size: 'Small', direction: 'North')

    plant1 = Plant.create!(name: 'Sage', description: 'Best plant', days_to_harvest: 70)
    plant2 = Plant.create!(name: 'Basil', description: 'Good plant', days_to_harvest: 80)
    plant3 = Plant.create!(name: 'Tomato', description: 'Versatile plant', days_to_harvest: 101)
    plant4 = Plant.create!(name: 'Lime', description: 'Sour plant', days_to_harvest: 90)

    PlantPlot.create!(plant: plant1, plot: plot1)
    PlantPlot.create!(plant: plant3, plot: plot1)
    PlantPlot.create!(plant: plant1, plot: plot2)
    PlantPlot.create!(plant: plant2, plot: plot2)
    PlantPlot.create!(plant: plant3, plot: plot2)
    PlantPlot.create!(plant: plant1, plot: plot3)

    visit "/gardens/#{garden.id}"

    within '#plants' do
      expect(page).to have_content('Sage')
      expect(page).to have_content('Basil')
      expect(page).to_not have_content('Tomato')
      expect(page).to_not have_content('Lime')
    end
  end

  it 'list plants sorted by number of appearances' do
    garden = Garden.create!(name: 'Turing Community Garden', organic: true)
    plot1 = garden.plots.create!(number: 1, size: 'Large', direction: 'East')
    plot2 = garden.plots.create!(number: 2, size: 'Medium', direction: 'West')
    plot3 = garden.plots.create!(number: 3, size: 'Small', direction: 'North')

    plant1 = Plant.create!(name: 'Sage', description: 'Best plant', days_to_harvest: 70)
    plant2 = Plant.create!(name: 'Basil', description: 'Good plant', days_to_harvest: 80)
    plant3 = Plant.create!(name: 'Tomato', description: 'Versatile plant', days_to_harvest: 95)
    plant4 = Plant.create!(name: 'Lime', description: 'Sour plant', days_to_harvest: 90)

    PlantPlot.create!(plant: plant1, plot: plot1)
    PlantPlot.create!(plant: plant2, plot: plot1)
    PlantPlot.create!(plant: plant1, plot: plot2)
    PlantPlot.create!(plant: plant2, plot: plot2)
    PlantPlot.create!(plant: plant2, plot: plot2)
    PlantPlot.create!(plant: plant3, plot: plot3)

    visit "/gardens/#{garden.id}"

    within '#plants' do
      expect('Basil').to appear_before('Sage')
      expect('Sage').to appear_before('Tomato')
    end
  end
end
