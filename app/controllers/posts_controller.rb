class PostsController < ApplicationController

  get '/posts' do
    if logged_in?
      @posts = Post.all
      erb :'/posts/posts'
    else
      redirect to '/login'
    end
  end

  get '/posts/new' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/posts/create_post'
    end
  end

  post '/posts' do
    if logged_in?
        if params[:content] == ""
          redirect to '/posts/new'
        else
          current_user.posts.create(title: params[:title], content: params[:content])
          redirect to "/posts/#{@post.id}"
        end
    else
        rediretct to '/login'
    end
  end


  get '/posts/:id' do
    if logged_in?
      @post = Post.find_by_id(params[:id])
      erb :'/posts/show_post'
    else
      redirect to '/login'
    end
  end

  get '/posts/:id/edit' do
    if logged_in?
      @post = Post.find_by_id(params[:id])
      if @post.user == current_user
        erb :'/posts/edit_post'
      else
        redirect to '/posts'
      end
    else
      redirect to '/login'
    end
  end

  patch '/posts/:id' do
    if logged_in?
        if params[:content] == ""
          redirect to "/posts/#{params[:id]}/edit"
        else
          @post = Post.find_by_id(params[:id])
          @post.update(title: params[:title], content: params[:content])
          redirect to "/posts/#{@post.id}"
        end
    else
        redirect to '/login'
    end
  end

  delete '/posts/:id/delete' do
    if logged_in?
      @post = Post.find_by_id(params[:id])
      if @post.user_id == current_user.id
        @post.delete
        redirect to '/posts'
      else
        redirect to '/posts'
      end
    else
      redirect to '/login'
    end
  end

end
