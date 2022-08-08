class Garden < ApplicationRecord
  has_many :plots
  has_many :plant_plots, through: :plots
  has_many :plants, through: :plant_plots

  def sorted_plants_list
    plants.select('plants.*, COUNT(plant_plots.id) plant_count')
          .where('days_to_harvest < ?', 100)
          .group(:id)
          .order('plant_count DESC')
          .distinct
  end
end
