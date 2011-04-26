class QuestionsController < ApplicationController
  def index
    if params[:commit]
      @questions = Question.find_all_by_category_id(
        make_category_id_filter_condition(
          params[:filter_category_id], params[:include_subcategories]
        )
      )
    else
      @questions = Question.all
    end
  end

  # in: category id (possibly nil)
  #     include subcategories flag
  # out: something we can pass to find_all_by_category_id
  def make_category_id_filter_condition(id, include_subcategories)
    case
    when id.blank?
      nil
    when include_subcategories
      [id] +  Category.find(id).descendants.map(&:id)
    else
      id
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
    # Assume that if we are making a question there will be at least
    # one answer to it.
    @question.answers.build
  end

  def create
    @question = Question.new(params[:question])
    if @question.save
      redirect_to @question, :notice => "Successfully created question."
    else
      render :action => 'new'
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params[:question])
      redirect_to @question, :notice  => "Successfully updated question."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_url, :notice => "Successfully destroyed question."
  end
end
