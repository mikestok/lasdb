class QuestionsController < ApplicationController
  def index
    if params[:commit]
      @questions = Question.find_all_by_category_id(
        make_category_id_filter_condition(
          params[:filter_category_id], params[:include_subcategories]
        ),
        :include => [:answers, :category]
      )
    else
      @questions = Question.all(:include => [:answers, :category])
    end
  end

  def shuffle_answers
    @question      = Question.find(params[:id])
    @target_div_id = params[:target_div_id]
    respond_to do |format|
      format.js
    end
  end

  def move_answer
    @question = Question.find(params[:id])
    answer = Answer.find(params[:answer_id])
    case params[:direction]
    when "up" then answer.move_higher
    when "down" then answer.move_lower
    end
    respond_to do |format|
      format.js
    end
  end

  def delete_answer
    @question = Question.find(params[:id])
    answer = Answer.find(params[:answer_id])
    answer.destroy
    respond_to do |format|
      format.js { render "move_answer" }
    end
  end

  def add_answer
    @question = Question.find(params[:id])
    Answer.create(:text => 'a new answer', :question_id => @question.id).move_to_bottom
    respond_to do |format|
      format.js { render "move_answer" }
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
    load_question_answers_and_category
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params[:question])
    if @question.save
      redirect_to edit_question_path(@question), :notice => "Successfully created question."
    else
      render :action => 'new'
    end
  end

  def edit
    load_question_answers_and_category
  end

  def update
    load_question_answers_and_category
    if @question.update_attributes(params[:question])
      redirect_to @question, :notice  => "Successfully updated question."
    else
      render :action => 'edit'
    end
  end

  def destroy
    Question.find(params[:id]).destroy
    redirect_to questions_url, :notice => "Successfully destroyed question."
  end

  private

  def load_question_answers_and_category
    @question = Question.find(
      params[:id],
      :include => [:answers, :category]
    )
  end
end
