class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_article, only: %i[ show edit update destroy ]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /articles or /articles.json
  def index
    @articles = Article.all.order(created_at: :desc)
  end

  # GET /articles/1 or /articles/1.json
  def show
    authorize @article
  end

  # GET /articles/new
  def new
    @article = Article.new
    authorize @article
  end

  # GET /articles/1/edit
  def edit
    authorize @article
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    authorize @article
    if @article.save
      @article.save_article_images
      redirect_to article_url(@article), notice: "Article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    authorize @article
    if @article.update(article_params)
      @article.save_article_images
      redirect_to article_url(@article), notice: "Article was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    authorize @article
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def upload_image
    image = params[:image]
    if image.nil?
      render json: { success: 0, error: "No image found in request" }
      return
    end
    upload_image = ArticleImage.create! image: image
    stored_image_url = rails_blob_url(upload_image.image)
    render json: { success: 1, file: { url: stored_image_url } }
  rescue StandardError => e
    render json: { success: 0, error: e.message }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :content, :image)
  end

  def user_not_authorized
    flash[:alert] = "You are not allowed to do that action"
    redirect_to(request.referrer || root_path)
  end
end
