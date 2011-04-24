class QuestionsController < ApplicationController
  def index
    @questions = Question.all
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
    @categories = Category.all.sort
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
