class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]

  # GET /todos or /todos.json
  def index
    @todos = Todo.order(created_at: :desc)
  end

  # GET /todos/1 or /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos or /todos.json
    # POST /todos or /todos.json
  def create
    @todo = Todo.new(todo_params.merge(status: false))
    respond_to do |format|
      if @todo.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("todos-list", partial: "todo", locals: { todo: @todo }),
            turbo_stream.update("empty-state", partial: "empty_state", locals: { todos: Todo.all }),
            turbo_stream.replace("new_todo", partial: "form", locals: { todo: Todo.new })
          ]
        end
        format.html { redirect_to todo_url(@todo), notice: "Quest was successfully created." }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("new_todo", partial: "form", locals: { todo: Todo.new })
        }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to root_path, notice: "Quest updated successfully." }
        format.json { render json: { status: @todo.status, message: "Quest updated successfully" }, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy!

    respond_to do |format|
      format.html { redirect_to todos_path, status: :see_other, notice: "Todo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.expect(todo: [ :title, :status ])
    end
end
