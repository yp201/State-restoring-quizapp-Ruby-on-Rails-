class QuizzesController < ApplicationController
  def new
  	@quiz=Quiz.new
  end

  def show
    @quiz = Quiz.find(params[:id])
  end 

  def skipquestion
    @quiz = Quiz.find(params[:id])
    if @quiz.powerup==false
      render :json => {:error => "You have already used this lifeline" },:status => 401  
    else
      @quiz.score+=50
      @quiz.powerup=false
      @quiz.current_question=@quiz.current_question+1
      if @quiz.save
        render json:@quiz
      end
    end
  end

  

  def currentquestion

    @quiz = Quiz.find(params[:id])
    @quiz.current_question=(params[:current_question])
    @quiz.powerup=params[:powerup]
    @quiz.score+=checkanswer params[:answer],@quiz.subgenre_id,@quiz.current_question-1
    puts @quiz.score  
    if @quiz.save
      render json: @quiz
    end

  end

  def quizdone
    @quiz = Quiz.find(params[:id])
    @quiz.ongoing=false
    @quiz.score+=checkanswer params[:answer],@quiz.subgenre_id,@quiz.current_question
    puts "score:"
    puts @quiz.score
    leaderboard_genre @quiz.score,@quiz.user_id,@quiz.genre_id
    leaderboard_subgenre @quiz.score,@quiz.user_id,@quiz.subgenre_id
    str='Quiz Complete, your score was '  
    str+= @quiz.score.to_s
    if @quiz.save
      render :js => "alert('Quiz Complete'); window.location = '/users/#{current_user.id}'"
    end

  end

  def fifty50
  
    @quiz = Quiz.find(params[:id])
    if @quiz.fifty_fifty?
      puts @quiz.fifty_fifty 
      @questions = Question.where subgenre_id: @quiz.subgenre_id

      if @questions[params[:current_question].to_i-1].answer.length == 1 
        puts @questions[params[:current_question].to_i-1].answer.length
        puts @questions[params[:current_question].to_i-1].answer[0]
        puts (@questions[params[:current_question].to_i-1 ].answer[0]+1)%4
        @quiz.fifty_fifty=false
        @quiz.save
        render :json => {:options => [@questions[params[:current_question].to_i-1].answer[0],(@questions[params[:current_question].to_i-1 ].answer[0]+1)%4]}
      else
      render :json => {:error => "Not valid  on this  question" },:status => 401  
      end
    else
      puts @quiz.fifty_fifty
      render :json => {:error => "You have already used this lifeline" },:status => 401  
        # render :json =>  {:error => "You have already used this lifeline" , status: 500}  
    end
  end

  def create
    # @quiz = Quiz.new(quiz_params)
    puts "here"
    puts params[:user_id]
    puts quizon params[:user_id],params[:subgenre_id]
    if quizon params[:user_id],params[:subgenre_id]
      puts "checkhere" 
      puts params[:user_id]
      puts quizon params[:user_id],params[:subgenre_id]
      @quiz = Quiz.new(quiz_params)
      if @quiz.save
        redirect_to @quiz
      else
        render 'new'
      end
    else
      render :json => {:error => "You have already used this lifeline" },:status => 401  
      # @user= User.find(params[:user_id])
      # redirect_to @user
    end
  end

  private

    def quiz_params
      params.permit(:user_id, :genre_id, :subgenre_id,:score, :ongoing, :current_question ,:quizname, :genre_name, :fifty_fifty)
    end

end
