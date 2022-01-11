class CommentsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_comment, only: [:destroy]
  # GET /comments or /comments.json
  

  # POST /comments or /comments.json
  def create
    @new_comment = @event.comments.build(comment_params)
  # Проставляем пользователя, если он задан
    @new_comment.user = current_user

    if @new_comment.save
    # Если сохранился, редирект на страницу самого события
    redirect_to @event, notice: I18n.t('controllers.comments.created')
    else
    # Если ошибки — рендерим здесь же шаблон события (своих шаблонов у коммента нет)
    render 'events/show', alert: I18n.t('controllers.comments.error')
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    message = {notice: I18n.t('controllers.comments.destroyed')}

    if current_user_can_edit?(@comment)
      @comment.destroy!
    else
      message = {alert: I18n.t('controllers.comments.error')}
    end

  redirect_to @event, message
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body, :user_name)
    end

    def set_event
      @event = Event.find(params[:event_id])
    end
    
    # Комментарий будем искать не по всей базе,
    # а у конкретного события
    def set_comment
      @comment = @event.comments.find(params[:id])
    end

end
