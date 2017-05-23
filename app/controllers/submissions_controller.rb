class SubmissionsController < ApplicationController
  before_action :authenticate!
  # GET /submissions
  def index
    @submissions = Submission.all
  end

  # GET /submissions/1
  def show
    @membership = Membership.find(params[:membership_id])

    @submission = @membership.submissions.find(params[:id])
    @comment = @submission.comments.new
    @comments = @submission.comments.order(created_at: :desc)
  end

  # GET /submissions/new
  def new
    @membership = Membership.find(params[:membership_id])

    @submission = @membership.submissions.new
  end

  # GET /submissions/1/edit
  def edit
    @membership = Membership.find(params[:membership_id])

    @submission = @membership.submissions.find(params[:id])
  end

  # POST /submissions
  def create
    @membership = Membership.find(params[:membership_id])
    @submission = @membership.submissions.new(submission_params)

    if @submission.save
      redirect_to author_submissions_group_path(@membership.group, @membership.user), notice: 'Submission was successfully created.'
      WorkingtitleMailer.submission_to_the_group(@submission, group_url(@submission.membership.group)).deliver
    else
      render :new
    end
  end

  # PATCH/PUT /submissions/1
  def update
    @membership = Membership.find(params[:membership_id])

    @submission = @membership.submissions.find(params[:id])
    if @submission.update(submission_params)
      redirect_to author_submissions_group_path(@membership.group, @membership.user), notice: 'Submission was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /submissions/1
  def destroy
    @submission = Submission.find(params[:id])
    @submission.destroy
    redirect_to submissions_url, notice: 'Submission was successfully destroyed.'
  end

  private

  # Only allow a trusted parameter "white list" through.
  def submission_params
    params.require(:submission).permit(:intro, :body, :due_by)
  end
end
