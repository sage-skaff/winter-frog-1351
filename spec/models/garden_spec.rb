require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe 'instance methods' do
    it 'lists unique plants from gardens plots that take less than 100 days to harvest sorted by number of plants' do
      garden = Garden.create!(name: 'Turing Community Garden', organic: true)
      plot1 = garden.plots.create!(number: 1, size: 'Large', direction: 'East')
      plot2 = garden.plots.create!(number: 2, size: 'Medium', direction: 'West')
      plot3 = garden.plots.create!(number: 3, size: 'Small', direction: 'North')

      plant1 = Plant.create!(name: 'Sage', description: 'Best plant', days_to_harvest: 70)
      plant2 = Plant.create!(name: 'Basil', description: 'Good plant', days_to_harvest: 80)
      plant3 = Plant.create!(name: 'Tomato', description: 'Versatile plant', days_to_harvest: 101)
      plant4 = Plant.create!(name: 'Lime', description: 'Sour plant', days_to_harvest: 90)

      PlantPlot.create!(plant: plant1, plot: plot1)
      PlantPlot.create!(plant: plant2, plot: plot1)
      PlantPlot.create!(plant: plant1, plot: plot2)
      PlantPlot.create!(plant: plant2, plot: plot2)
      PlantPlot.create!(plant: plant2, plot: plot2)
      PlantPlot.create!(plant: plant3, plot: plot3)

      expect(garden.sorted_plants_list).to eq([plant2, plant1])
    end
  end
end
