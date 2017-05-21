class CommentsController < ApplicationController
  before_action :authenticate!

  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show
    @comment = Comment.find(params[:id])
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    @submission = @comment.submission
    @comment.submission_id = @submission.submission_id
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  def create
    @submission = Submission.find(params[:submission_id])
    @comment = @submission.comments.create(comment_params)
    @comment.created_by_id = current_user.id

    if @comment.save
      redirect_to membership_submission_path(@submission.membership.id, @submission.id), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /comments/1
  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to membership_submission_path, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /comments/1
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:body)
  end
end
