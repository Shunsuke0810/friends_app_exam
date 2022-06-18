class NoticeMailer < ApplicationMailer

  def notice_mail(contact)
    mail to: contact.user.email, subject: "画像投稿の確認メール" 
  end

end
