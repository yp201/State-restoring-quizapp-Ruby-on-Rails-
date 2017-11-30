module ApplicationHelper
	
	def log_in(user)
      session[:user_id] = user.id
  	end

  	def goto(user)
  		redirect_to user
  	end
  	def current_user
    	@current_user ||= User.find_by(id: session[:user_id])
  	end

  	def logged_in?
    	!current_user.nil?
  	end

  	def log_out
	  	session.delete(:user_id)
	    @current_user = nil
  	end

    def all_genres
      @genre=Genre.all
    end

    def all_questions(subgenre_id)
      @questions = Question.where subgenre_id: subgenre_id
      for i in 0..@questions.length-1
        @questions[i].answer=[]
      end
      @questions.to_json
    end

    def getongoingquiz(user_id)
      @quiz= Quiz.where(user_id:user_id,ongoing:true)      
    end

    def quizon(user_id,subgenre_id)
      @quiz_temp= Quiz.where(user_id:user_id,ongoing:true,subgenre_id:subgenre_id)
      puts @quiz_temp      
      if @quiz_temp[0].nil?
        return true
      else
        return false
      end
    end

    def checkanswer(answer,subgenre_id,current_question)
      questions = Question.where subgenre_id: subgenre_id
      if answer.nil?
        return 0
      end

        for i in 0..answer.length-1 
          answer[i]=answer[i].to_i
        end

        if questions[current_question-1].answer == answer
          puts "correct"
          return 100
        else
          puts "incorrect"
          return 0
        end
    end

    def leaderboard_genre(score,user_id,genre_id)
      @leaderboard_genre=LeaderboardGenre.find_by(genre_id:genre_id)
      @leaderboard_genre.ranklist.each do |x| 

        if x[1]==user_id
          flag=false
          if x[0]<score
            x[0]=score
          end
            @leaderboard_genre.ranklist=@leaderboard_genre.ranklist.sort
            @leaderboard_genre.save
          return
        end

      end

        @leaderboard_genre.ranklist.append([score,user_id])
        @leaderboard_genre.ranklist=@leaderboard_genre.ranklist.sort
        @leaderboard_genre.save
      
    end

    def leaderboard_subgenre(score,user_id,subgenre_id)
      @leaderboard_subgenre=LeaderboardSubgenre.find_by(subgenre_id:subgenre_id)
      @leaderboard_subgenre.ranklist.each do |x| 

        if x[1]==user_id
          flag=false
          if x[0]<score
            x[0]=score
          end
            @leaderboard_subgenre.ranklist=@leaderboard_subgenre.ranklist.sort
            @leaderboard_subgenre.save
          return
        end

      end

        @leaderboard_subgenre.ranklist.append([score,user_id])
        @leaderboard_subgenre.ranklist=@leaderboard_subgenre.ranklist.sort
        @leaderboard_subgenre.save
      
    end

    def ranklist_genre()
      @leaderboard_genre=LeaderboardGenre.all
      @leaderboard_genre.to_json
    end

    def ranklist_subgenre()
      @leaderboard_subgenre=LeaderboardSubgenre.all
      @leaderboard_subgenre.to_json
    end


    def userlist()
      @user=User.all
      @user.to_json
    end

    def genrelist()
      @genre=Genre.all
      @genre.to_json
    end

    def subgenrelist()
      @subgenre=Subgenre.all
      @subgenre.to_json
    end

    def taken_quizzes(user_id)
      quizzes = Quiz.where user_id: user_id, ongoing:false
      subgenre= Subgenre.all
      temp=[]
      attempted=[]
      notattempted=[]

      for i in 0..quizzes.length-1
        temp.push([quizzes[i].subgenre_id.to_i,quizzes[i].score])
      end
      for j in 0..subgenre.length-1
        flag=true
        for i in 0..temp.length-1
          if temp[i][0]==subgenre[j].id
            flag=false
            attempted.push([subgenre[j].genre.name,subgenre[j].name,temp[i][1]])
          end
        end    
        if flag
          notattempted.push([subgenre[j].genre.name,subgenre[j].name])
        end
      end
      return { :attempted => attempted, :notAttempted => notattempted }.to_json  

    end
      
    

end
