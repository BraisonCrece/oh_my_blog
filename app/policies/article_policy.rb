class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def index?
      true
    end

    def show?
      true
    end

    def create?
      user.present?
    end

    def update?
      user.present? && user == record.user
    end

    def destroy?
      update?
    end
  end
end
