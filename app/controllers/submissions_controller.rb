class SubmissionsController < ApplicationController
  # GET /submissions
  def index
    @submissions = Submission.all
  end

  # GET /submissions/1
  def show
    @membership = Membership.find(params[:membership_id])

    @submission = @membership.submissions.find(params[:id])
  end

  # GET /submissions/new
  def new
    @membership = Membership.find(params[:membership_id])

    @submission = @membership.submissions.new
  end

  # GET /submissions/1/edit
  def edit
    @submission = Submission.find(params[:id])
  end

  # POST /submissions
  def create
    @membership = Membership.find(params[:membership_id])
    @submission = @membership.submissions.new(submission_params)

    if @submission.save
      redirect_to author_submissions_group_path(@membership.group, @membership.user), notice: 'Submission was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /submissions/1
  def update
    @submission = Submission.find(params[:id])
    if @submission.update(submission_params)
      redirect_to @submission, notice: 'Submission was successfully updated.'
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
    params.require(:submission).permit(:intro, :body)
  end
end
