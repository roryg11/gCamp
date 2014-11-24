 class FaqController < ApplicationController
  def questions
  @faq_answer = [
    ["What is gCamp?", "gCamp is an awesome tool that is going to change your life.
    gCamp is your one stop shop to organize all of your tasks and documents.
    You'll also be able to track comments that you and others make. gCamp may
    eventually replace to need for paper and pens in the entire world. Well, maybe not,
    but it's going to be pretty cool."] ,

    ["How do I join gCamp?", "gCamp is still in production. So, there is not a sign-up page open to the
    public, yet. Your best option is to become super best friends with a gCamp
    developer. They can be found hanging around gSchool during the day and hitting
    the hottest clubs at night."],

    ["When will gCamp be finished?", "gCamp is a work in progress. That said, it should be fully functional by
    December 2014. Functional, but our developers are going to continue to improve
    the site for the foreseeable future. Check in daily for new features and
    awesome functionality. It's going to blow your mind. Organization is only(will
    only be) a click away. Amazing!"],
  ]
  end
end
