class DemoPartialsController < ApplicationController
  def new
    @zone = "zone today"
    @date = Time.zone.today
  end

  def edit
    @zone = "zone edit today"
    @date = Time.zone.today - 4
  end
end
