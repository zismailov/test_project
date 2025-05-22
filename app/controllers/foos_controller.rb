class FoosController < ApplicationController
  before_action :set_foo, only: %i[ show edit update destroy ]

  def index
    @foos = Foo.page(params[:page]).per(10)
  end

  def show
    @foo = Foo.find(params[:id])
    @foos = Foo.page(params[:page]).per(10)
    @bars = @foo.bars.page(params[:page]).per(5)
  end

  def new
    @foo = Foo.new
  end

  def edit
  end

  def create
    @foo = Foo.new(foo_params)

    if @foo.save
      flash[:notice] = "Объект успешно создан"
      redirect_to foos_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @foo.update(foo_params)
      respond_to do |format|
        format.html { redirect_to foos_path, notice: "Объект успешно обновлен" }
        format.turbo_stream { 
          render turbo_stream: turbo_stream.replace(
            dom_id(@foo),
            partial: "foos/foo",
            locals: { foo: @foo }
          )
        }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @foo.destroy
    flash[:notice] = "Объект успешно удален"
    redirect_to foos_url, status: :see_other
  end

  private

  def set_foo
    @foo = Foo.find(params[:id])
  end

  def foo_params
    params.require(:foo).permit(:name)
  end
end 