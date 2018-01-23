class TrainingPrioritiesController < ApplicationController
  before_filter :require_login

    def sort
    params[:training_priority].each_with_index do |id, index|
      TrainingPriority.update_all(['priority=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
  
end