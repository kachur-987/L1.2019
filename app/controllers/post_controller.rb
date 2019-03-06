class PostsController < InheritedResources::Base
    before_action :authenticate_user!, except: %i[index show]
    before_action :find_post, only: %i[show edit update destroy]

    def index
      @posts = Post.all
    end

    def new
      @post = Post.new
    end

    def create

      @post = current_user.posts.build(post_params)
      if @post.save

        redirect_to post_path(@post.id)
      else
        render 'new'
      end

    end

    def show
            end

    def edit; end

    def update

      if @post.save

        redirect_to post_path(@post.id)
      else
        render 'edit'
      end
    end

    def destroy
      @post.destroy
      redirect_to posts_path
    end

    private

    def post_params
      params.require(:post).permit(:user_id, :title, :body)
    end

    def find_post
      @post = Post.find(params[:id])
    end
end
