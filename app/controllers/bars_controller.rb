class BarsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_foo
  before_action :set_bar, only: %i[edit update destroy]

  def index
    @bars = @foo.bars.page(params[:page]).per(5)
    @bar = @foo.bars.build

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
  end

  def new
    @bar = @foo.bars.build
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    @bar = @foo.bars.build(bar_params)

    if @bar.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append("bars", partial: "bars/bar", locals: { bar: @bar }),
            turbo_stream.update("new_bar", partial: "bars/form", locals: { bar: Bar.new })
          ]
        end
        format.html { redirect_to foo_path(@foo), notice: "Запись успешно создана" }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "new_bar",
            partial: "bars/form",
            locals: { bar: @bar }
          ), status: :unprocessable_entity
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @bar.update(bar_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            dom_id(@bar),
            partial: "bars/bar",
            locals: { bar: @bar }
          )
        end
        format.html { redirect_to foo_path(@foo), notice: "Запись успешно обновлена" }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            dom_id(@bar),
            partial: "bars/form",
            locals: { bar: @bar }
          ), status: :unprocessable_entity
        end
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bar.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@bar) }
      format.html { redirect_to foo_path(@foo), notice: "Запись успешно удалена" }
    end
  end

  private

  def set_foo
    @foo = Foo.find(params[:foo_id])
  end

  def set_bar
    @bar = @foo.bars.find(params[:id])
  end

  def bar_params
    params.require(:bar).permit(:name, :description)
  end
end 