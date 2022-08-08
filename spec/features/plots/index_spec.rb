require 'rails_helper'

RSpec.describe 'plots index page' do
  it 'lists all plot numbers' do
    garden = Garden.create!(name: 'Turing Community Garden', organic: true)
    plot1 = garden.plots.create!(number: 1, size: 'Large', direction: 'East')
    plot2 = garden.plots.create!(number: 2, size: 'Medium', direction: 'West')
    plot3 = garden.plots.create!(number: 3, size: 'Small', direction: 'North')

    visit '/plots'

    within "#plot-#{plot1.id}" do
      expect(page).to have_content('Plot #1')
      expect(page).to_not have_content('Plot #2')
    end

    within "#plot-#{plot2.id}" do
      expect(page).to have_content('Plot #2')
      expect(page).to_not have_content('Plot #3')
    end

    within "#plot-#{plot3.id}" do
      expect(page).to have_content('Plot #3')
      expect(page).to_not have_content('Plot #1')
    end
  end

  it 'lists names of plots plants' do
    garden = Garden.create!(name: 'Turing Community Garden', organic: true)
    plot1 = garden.plots.create!(number: 1, size: 'Large', direction: 'East')
    plot2 = garden.plots.create!(number: 2, size: 'Medium', direction: 'West')
    plot3 = garden.plots.create!(number: 3, size: 'Small', direction: 'North')

    plant1 = Plant.create!(name: 'Sage', description: 'Best plant', days_to_harvest: 70)
    plant2 = Plant.create!(name: 'Basil', description: 'Good plant', days_to_harvest: 80)
    plant3 = Plant.create!(name: 'Tomato', description: 'Versatile plant', days_to_harvest: 90)

    PlantPlot.create!(plant: plant1, plot: plot1)
    PlantPlot.create!(plant: plant3, plot: plot1)
    PlantPlot.create!(plant: plant1, plot: plot2)
    PlantPlot.create!(plant: plant2, plot: plot2)
    PlantPlot.create!(plant: plant3, plot: plot2)
    PlantPlot.create!(plant: plant1, plot: plot3)

    visit '/plots'

    within "#plot-#{plot1.id}" do
      expect(page).to have_content('Sage')
      expect(page).to have_content('Tomato')
      expect(page).to_not have_content('Basil')
    end

    within "#plot-#{plot2.id}" do
      expect(page).to have_content('Sage')
      expect(page).to have_content('Tomato')
      expect(page).to have_content('Basil')
    end

    within "#plot-#{plot3.id}" do
      expect(page).to have_content('Sage')
      expect(page).to_not have_content('Basil')
      expect(page).to_not have_content('Tomato')
    end
  end

  it 'has link to remove plant next to each plants name' do
    garden = Garden.create!(name: 'Turing Community Garden', organic: true)
    plot1 = garden.plots.create!(number: 1, size: 'Large', direction: 'East')
    plot2 = garden.plots.create!(number: 2, size: 'Medium', direction: 'West')
    plot3 = garden.plots.create!(number: 3, size: 'Small', direction: 'North')

    plant1 = Plant.create!(name: 'Sage', description: 'Best plant', days_to_harvest: 70)
    plant2 = Plant.create!(name: 'Basil', description: 'Good plant', days_to_harvest: 80)
    plant3 = Plant.create!(name: 'Tomato', description: 'Versatile plant', days_to_harvest: 90)

    pp1 = PlantPlot.create!(plant: plant1, plot: plot1)
    pp2 = PlantPlot.create!(plant: plant3, plot: plot1)
    pp3 = PlantPlot.create!(plant: plant1, plot: plot2)
    pp4 = PlantPlot.create!(plant: plant2, plot: plot2)
    pp5 = PlantPlot.create!(plant: plant3, plot: plot2)
    pp6 = PlantPlot.create!(plant: plant1, plot: plot3)

    visit '/plots'

    within "#plot-#{plot1.id}" do
      within "#plant-#{pp1.id}" do
        expect(page).to have_link('Remove Plant')
      end

      within "#plant-#{pp2.id}" do
        expect(page).to have_content('Tomato')
        expect(page).to have_link('Remove Plant')
        click_link 'Remove Plant'
      end
    end

    expect(current_path).to eq('/plots')

    within "#plot-#{plot1.id}" do
      within "#plant-#{pp1.id}" do
        expect(page).to have_link('Remove Plant')
      end
      expect(page).to_not have_content('Tomato')
    end
  end
end
