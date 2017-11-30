// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

var subgenres = {};
var all_questions=[];
var checkboxValues = [];
current_question=1;
var score=0;
var quizId;
var genre_name;
var genre_id=1;
var leaderboard_genre;
var leaderboard_subgenre;
var takenQuizzes  ;
var userList;
var genreList;
var subgenreList;
var powerup=true
var doubledip=false;
var loadSubGenres = function(genre_id) {
  $.ajax({
    url: '/allsubgenres',
    async: false,
    data: {
      'genre_id': genre_id
    },
    method: 'GET',
    success: function(response) {
      var subgenre, subgenre_str;
      subgenres = response;
      subgenre_str = '';
      for (subgenre in subgenres) {
        subgenre = subgenre;
        subgenre_str += '<option value=' + (parseInt(subgenre)+1) + '>' + subgenres[subgenre].name + '</option>';
      }
      console.log(subgenre_str);
      $('#subgenre').html(subgenre_str);
    },
    error: function(response) {}
  });
};

var newQuiz=function(user_id, genre_id, subgenre_id)
{
  id=subgenres[subgenre_id-1].id
  var genreName;
  for(i in genreList)
  {
    if (genreList[i].id==genre_id)
    {
      genreName=genreList[i].name
    }
  }
  $.ajax({
    url: '/newquiz',
    async: false,
    method: 'POST',
    data: {
      'user_id': user_id,
      'genre_id':genre_id,
      'subgenre_id':id,
      'score':0,
      'ongoing':true,
      'current_question':1,
      'quizname':subgenres[subgenre_id-1].name,
      'genre_name':genreName,
      'fifty_fifty':true
    },
    success: function(response) {
      current_question=1;
    },
    error: function(response) {
      alert('You already have a ongoing quiz for this topic')
    }
  });
}





var displayQuestion=function(current_question)
{
  console.log('1')
  $('#checkbox-1').removeClass('hidden')
  $('#checkbox-2').removeClass('hidden')
  $('#checkbox-3').removeClass('hidden')
  $('#checkbox-4').removeClass('hidden')
  
  $('#ques').html(all_questions[current_question-1].question)
  $('#1').html(all_questions[current_question-1].options[0]) 
  $('#checkbox-1').prop('checked', false);
  $('#2').html(all_questions[current_question-1].options[1]) 
  $('#checkbox-2').prop('checked', false);
  $('#3').html(all_questions[current_question-1].options[2]) 
  $('#checkbox-3').prop('checked', false);
  $('#4').html(all_questions[current_question-1].options[3]) 
  $('#checkbox-4').prop('checked', false);


}
var a;
var fifty50=function()
{
  var options;
  $.ajax({
  url: '/fifty',
  async: false,
  method: 'GET',
  data: {
    'id': quizId,
    'current_question':parseInt(current_question)
  },
  success: function(response) {
    alert('Two wrong answers will be taken off, this lifeline cant be used again')
    $('#fifty').attr('disabled','disabled');
    poweruptype2=0;
    options=response.options;
    $('#1').html("");
    $('#2').html("");
    $('#3').html("");
    $('#4').html("");
    $('#checkbox-1').addClass('hidden')
    $('#checkbox-2').addClass('hidden')
    $('#checkbox-3').addClass('hidden')
    $('#checkbox-4').addClass('hidden')
    $('#checkbox-'+options[0]).removeClass('hidden')

    $('#'+options[0]).html(all_questions[current_question-1].options[options[0]-1])
    if(options[1]==0)
    {
      options[1]=4;
    } 
    $('#checkbox-'+options[1]).removeClass('hidden')
    $('#'+options[1]).html(all_questions[current_question-1].options[options[1]-1])
  },
  error: function(response) {
    alert(response.responseJSON.error);
  }
  });
}

var skipQuestion=function()
{
  $.ajax({
    url: '/skipquestion',
    async: false,
    method: 'POST',
    data: {
      'id': quizId,
      'current_question':current_question
    },
    success: function(response) {
      $('#skip').attr('disabled','disabled');
      alert("You get 50 points for this question and the question gets skipped")
      current_question=response.current_question
      score=response.score;
      $('#score').html("SCORE: "+score);
      $('')
      displayQuestion(current_question);

    },
    error: function(response) {
      alert(response.responseJSON.error)
    }
  });
}
var answer=function()
{
  checkboxValues.sort();
  if(current_question==all_questions.length)
  {
   
    $.ajax({
    url: '/quizdone',
    async: false,
    method: 'POST',
    data: {
      'id': quizId,
      'score':score,
      'answer':checkboxValues,
      'current_question':current_question
    },
    success: function(response) {
    },
    error: function(response) {
    }
  });

  }
  else
  {
    
    current_question+=1;
    $.ajax({
    url: '/currentquestion',
    method: 'POST',
    async:false,
    data: {
      'id': quizId,
      'current_question':current_question,
      'score':score,
      'powerup':powerup,
      'answer':checkboxValues
    },
    success: function(response) 
    {

      current_question=response.current_question
      score=response.score
      $('#score').html("SCORE: "+score);
      displayQuestion(current_question)

    },
    error: function(response) {
      alert('error')
    }
  });

  }
}
var panelHeading=function(name,id){
    genre_name=name
    genre_id=id
    console.log(genre_name,genre_id)
    $.ajax({
    url: '/allsubgenres',
    async: false,
    data: {
      'genre_id': genre_id
    },
    method: 'GET',
    success: function(response) {
      var subgenre, subgenre_str;
      subgenres = response;
      subgenre_str = '<li><a id=\"0\" onclick=\"rankListSubgenre(this.id)\" > None</a></li>';
      for (subgenre in subgenres) {
        subgenre = subgenre;
        subgenre_str +="<li><a id=" +subgenres[subgenre].id+" onclick=\"rankListSubgenre(this.id)\">"+subgenres[subgenre].name +"</a></li>";
      }

      $('#subgenres-list').html(subgenre_str);
    },
    error: function(response) {}
  });
    
    $('#panel-heading').html(genre_name);
    $('#genre-heading').html(genre_name+" <span class=\"caret\"></span>");
    rankListGenre();
  }


var rankListGenre=function()
{
  
  var str="<tr><td>Rank</td><td>User Name</td><td>Score</td></tr>"
  var temprank=leaderboard_genre[genre_id-1].ranklist.sort().reverse();
  console.log(temprank)
  for(i in temprank)
  {
    var name=""
    rank=parseInt(i)+1
    for(j in userList)
    {
      if(userList[j].id==temprank[i][1])
      {
        name=userList[j].name
      }

    }
     str+="<tr><td>"+rank+"</td><td>"+name+"</td><td>"+leaderboard_genre[genre_id-1].ranklist[i][0];
    
  }
    console.log(str)
    $('#ranklist').html(str);
    $("#subgenre-heading").html("None <span class=\"caret\"></span>")
    return ;
}
var rankListSubgenre=function(subgenreid)
{
  var subgenre_name='None';
  subgenreid=parseInt(subgenreid)
  if(subgenreid==0)
  {
      $('#subgenre-heading').html(subgenre_name+" <span class=\"caret\"></span>");
      panelHeading($('#genre-heading').html().split(" ")[0],genre_id);  
  }
  else
  {

    for(i in subgenreList)
    {
      if(subgenreList[i].id==subgenreid)
      {
        console.log(i+"-->"+subgenreList[i].name+"-->"+subgenreid)
        subgenre_name=subgenreList[i].name
        subgenreid=parseInt(i)+1;
        console.log(subgenreid)
        break;
      }
    }
    var str="<tr><td>Rank</td><td>User Name</td><td>Score</td></tr>"
    console.log(subgenreid)
    var temprank=leaderboard_subgenre[subgenreid-1].ranklist.sort().reverse();
    console.log(temprank)
  for(i in temprank)
  {
    var name=""

      rank=parseInt(i)+1
    for(j in userList)
    {
      if(userList[j].id==temprank[i][1])
      {
        name=userList[j].name
      }

    }
     str+="<tr><td>"+rank+"</td><td>"+name+"</td><td>"+leaderboard_subgenre[subgenreid-1].ranklist[i][0];
    
  }
  $('#panel-heading').html(subgenre_name);
  $('#subgenre-heading').html(subgenre_name+" <span class=\"caret\"></span>");
  console.log(str)
  $('#ranklist').html(str);
  }

}
var previous= function()
{
 var str="<tr><td>Genre</td><td>Subgenre</td><td>Score</td></tr>" 
 for (i in takenQuizzes.attempted)
 {
  str+="<tr><td>"+takenQuizzes.attempted[i][0]+"</td><td>"+takenQuizzes.attempted[i][1]+"</td><td>"+takenQuizzes.attempted[i][2]+"</td>"
 }
 for (i in takenQuizzes.notAttempted)
 {
    str+="<tr><td>"+takenQuizzes.notAttempted[i][0]+"</td><td>"+takenQuizzes.notAttempted[i][1]+"</td><td>N.A</td>"

 }
 $('#previous').html(str)
}

var getAnswers=function ()
{
  checkboxValues=[]
  $('input[name=answer]:checked').map(function() 
  {
    checkboxValues.push(parseInt($(this).val()));
  });  
  answer();
}
var graph=function()
{

      // Load the Visualization API and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.charts.setOnLoadCallback(drawChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {
        temp=[]
        for (i in takenQuizzes.attempted){
          temp.push([takenQuizzes.attempted[i][1],takenQuizzes.attempted[i][2]]);
        }

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Subgenres');
        data.addColumn('number', 'Scores');
        data.addRows(temp);

        // Set chart options
        var options = {'title':'Scores in respective genres',
                       'width':600,
                       'height':400};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        var chart1 = new google.visualization.BarChart(document.getElementById('chart1_div'));
        chart.draw(data, options);
        chart1.draw(data, options);

      }
}
