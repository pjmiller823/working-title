class SubmissionsController < ApplicationController
  # GET /submissions
  def index
    @submissions = Submission.all
  end

  # GET /submissions/1
  def show
    @submission = Submission.find(params[:id])
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # GET /submissions/1/edit
  def edit
    @submission = Submission.find(params[:id])
  end

  # POST /submissions
  def create
    @submission = Submission.new(submission_params)

    if @submission.save
      redirect_to @submission, notice: 'Submission was successfully created.'
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
