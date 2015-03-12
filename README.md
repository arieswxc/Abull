# bull

### 默认的数据库是mysql数据库。使用前请先配置数据库文件
```
cp config/database.yml.default config/database.yml
```
```
                        Prefix Verb       URI Pattern                                    Controller#Action
        new_admin_user_session GET        /admin/login(.:format)                         active_admin/devise/sessions#new	管理员登陆
            admin_user_session POST       /admin/login(.:format)                         active_admin/devise/sessions#create
    destroy_admin_user_session DELETE|GET /admin/logout(.:format)                        active_admin/devise/sessions#destroy	管理员登出
           admin_user_password POST       /admin/password(.:format)                      active_admin/devise/passwords#create
       new_admin_user_password GET        /admin/password/new(.:format)                  active_admin/devise/passwords#new	管理员发邮件重设密码
      edit_admin_user_password GET        /admin/password/edit(.:format)                 active_admin/devise/passwords#edit 	管理员根据邮件链接重设密码
                               PATCH      /admin/password(.:format)                      active_admin/devise/passwords#update	管理员更换密码
                               PUT        /admin/password(.:format)                      active_admin/devise/passwords#update	管理员更换密码
              new_user_session GET        /users/sign_in(.:format)                       devise/sessions#new 			用户登陆
                  user_session POST       /users/sign_in(.:format)                       devise/sessions#create
          destroy_user_session DELETE     /users/sign_out(.:format)                      devise/sessions#destroy		用户登出
                 user_password POST       /users/password(.:format)                      devise/passwords#create
             new_user_password GET        /users/password/new(.:format)                  devise/passwords#new			用户发邮件重设密码
            edit_user_password GET        /users/password/edit(.:format)                 devise/passwords#edit			用户根据邮件链接重设密码
                               PATCH      /users/password(.:format)                      devise/passwords#update		用户更换密码
                               PUT        /users/password(.:format)                      devise/passwords#update		用户更换密码
      cancel_user_registration GET        /users/cancel(.:format)                        devise/registrations#cancel		
             user_registration POST       /users(.:format)                               devise/registrations#create		用户创建账户（注册）
         new_user_registration GET        /users/sign_up(.:format)                       devise/registrations#new 		用户创建账户（注册）
        edit_user_registration GET        /users/edit(.:format)                          devise/registrations#edit		用户编辑个人资料
                               PATCH      /users(.:format)                               devise/registrations#update		用户提交新的个人资料
                               PUT        /users(.:format)                               devise/registrations#update
                               DELETE     /users(.:format)                               devise/registrations#destroy 		用户删除账户
                    admin_root GET        /admin(.:format)                               admin/dashboard#index
    batch_action_admin_follows POST       /admin/follows/batch_action(.:format)          admin/follows#batch_action
                 admin_follows GET        /admin/follows(.:format)                       admin/follows#index
                               POST       /admin/follows(.:format)                       admin/follows#create
              new_admin_follow GET        /admin/follows/new(.:format)                   admin/follows#new
             edit_admin_follow GET        /admin/follows/:id/edit(.:format)              admin/follows#edit
                  admin_follow GET        /admin/follows/:id(.:format)                   admin/follows#show
                               PATCH      /admin/follows/:id(.:format)                   admin/follows#update
                               PUT        /admin/follows/:id(.:format)                   admin/follows#update
                               DELETE     /admin/follows/:id(.:format)                   admin/follows#destroy
batch_action_admin_admin_users POST       /admin/admin_users/batch_action(.:format)      admin/admin_users#batch_action
             admin_admin_users GET        /admin/admin_users(.:format)                   admin/admin_users#index
                               POST       /admin/admin_users(.:format)                   admin/admin_users#create
          new_admin_admin_user GET        /admin/admin_users/new(.:format)               admin/admin_users#new
         edit_admin_admin_user GET        /admin/admin_users/:id/edit(.:format)          admin/admin_users#edit
              admin_admin_user GET        /admin/admin_users/:id(.:format)               admin/admin_users#show
                               PATCH      /admin/admin_users/:id(.:format)               admin/admin_users#update
                               PUT        /admin/admin_users/:id(.:format)               admin/admin_users#update
                               DELETE     /admin/admin_users/:id(.:format)               admin/admin_users#destroy
               admin_dashboard GET        /admin/dashboard(.:format)                     admin/dashboard#index
  batch_action_admin_leverages POST       /admin/leverages/batch_action(.:format)        admin/leverages#batch_action
               admin_leverages GET        /admin/leverages(.:format)                     admin/leverages#index
                               POST       /admin/leverages(.:format)                     admin/leverages#create
            new_admin_leverage GET        /admin/leverages/new(.:format)                 admin/leverages#new
           edit_admin_leverage GET        /admin/leverages/:id/edit(.:format)            admin/leverages#edit
                admin_leverage GET        /admin/leverages/:id(.:format)                 admin/leverages#show
                               PATCH      /admin/leverages/:id(.:format)                 admin/leverages#update
                               PUT        /admin/leverages/:id(.:format)                 admin/leverages#update
                               DELETE     /admin/leverages/:id(.:format)                 admin/leverages#destroy
     batch_action_admin_topics POST       /admin/topics/batch_action(.:format)           admin/topics#batch_action
                  admin_topics GET        /admin/topics(.:format)                        admin/topics#index
                               POST       /admin/topics(.:format)                        admin/topics#create
               new_admin_topic GET        /admin/topics/new(.:format)                    admin/topics#new
              edit_admin_topic GET        /admin/topics/:id/edit(.:format)               admin/topics#edit
                   admin_topic GET        /admin/topics/:id(.:format)                    admin/topics#show
                               PATCH      /admin/topics/:id(.:format)                    admin/topics#update
                               PUT        /admin/topics/:id(.:format)                    admin/topics#update
                               DELETE     /admin/topics/:id(.:format)                    admin/topics#destroy
      batch_action_admin_users POST       /admin/users/batch_action(.:format)            admin/users#batch_action
                   admin_users GET        /admin/users(.:format)                         admin/users#index
                               POST       /admin/users(.:format)                         admin/users#create
                new_admin_user GET        /admin/users/new(.:format)                     admin/users#new
               edit_admin_user GET        /admin/users/:id/edit(.:format)                admin/users#edit
                    admin_user GET        /admin/users/:id(.:format)                     admin/users#show
                               PATCH      /admin/users/:id(.:format)                     admin/users#update
                               PUT        /admin/users/:id(.:format)                     admin/users#update
                               DELETE     /admin/users/:id(.:format)                     admin/users#destroy
      batch_action_admin_funds POST       /admin/funds/batch_action(.:format)            admin/funds#batch_action
                   admin_funds GET        /admin/funds(.:format)                         admin/funds#index
                               POST       /admin/funds(.:format)                         admin/funds#create
                new_admin_fund GET        /admin/funds/new(.:format)                     admin/funds#new
               edit_admin_fund GET        /admin/funds/:id/edit(.:format)                admin/funds#edit
                    admin_fund GET        /admin/funds/:id(.:format)                     admin/funds#show
                               PATCH      /admin/funds/:id(.:format)                     admin/funds#update
                               PUT        /admin/funds/:id(.:format)                     admin/funds#update
                               DELETE     /admin/funds/:id(.:format)                     admin/funds#destroy
 batch_action_admin_news_index POST       /admin/news/batch_action(.:format)             admin/news#batch_action
              admin_news_index GET        /admin/news(.:format)                          admin/news#index
                               POST       /admin/news(.:format)                          admin/news#create
                new_admin_news GET        /admin/news/new(.:format)                      admin/news#new
               edit_admin_news GET        /admin/news/:id/edit(.:format)                 admin/news#edit
                    admin_news GET        /admin/news/:id(.:format)                      admin/news#show
                               PATCH      /admin/news/:id(.:format)                      admin/news#update
                               PUT        /admin/news/:id(.:format)                      admin/news#update
                               DELETE     /admin/news/:id(.:format)                      admin/news#destroy
    batch_action_admin_invests POST       /admin/invests/batch_action(.:format)          admin/invests#batch_action
                 admin_invests GET        /admin/invests(.:format)                       admin/invests#index
                               POST       /admin/invests(.:format)                       admin/invests#create
              new_admin_invest GET        /admin/invests/new(.:format)                   admin/invests#new
             edit_admin_invest GET        /admin/invests/:id/edit(.:format)              admin/invests#edit
                  admin_invest GET        /admin/invests/:id(.:format)                   admin/invests#show
                               PATCH      /admin/invests/:id(.:format)                   admin/invests#update
                               PUT        /admin/invests/:id(.:format)                   admin/invests#update
                               DELETE     /admin/invests/:id(.:format)                   admin/invests#destroy
                admin_comments GET        /admin/comments(.:format)                      admin/comments#index
                               POST       /admin/comments(.:format)                      admin/comments#create
                 admin_comment GET        /admin/comments/:id(.:format)                  admin/comments#show
                          root GET        /                                              welcome#index			主页
                  user_invests GET        /users/:user_id/invests(.:format)              profile/invests#index		用户投资index页
                   user_invest GET        /users/:user_id/invests/:id(.:format)          profile/invests#show		用户投资show页
                    user_funds GET        /users/:user_id/funds(.:format)                profile/funds#index 		用户发标index页
                     user_fund GET        /users/:user_id/funds/:id(.:format)            profile/funds#show 		用户发标show页
                user_leverages GET        /users/:user_id/leverages(.:format)            profile/leverages#index	用户配资index页
                 user_leverage GET        /users/:user_id/leverages/:id(.:format)        profile/leverages#show 	用户配资show页
         user_following_topics GET        /users/:user_id/following_topics(.:format)     profile/following_topics#index 用户好友话题index页
          user_following_topic GET        /users/:user_id/following_topics/:id(.:format) profile/following_topics#show 	用户好友话题show页
           edit_real_name_user GET        /users/:id/edit_real_name(.:format)            users#edit_real_name		实名认证
         update_real_name_user PUT        /users/:id/update_real_name(.:format)          users#update_real_name		提交实名认证
                  fund_invests GET        /funds/:fund_id/invests(.:format)              invests#index			投资index页
                               POST       /funds/:fund_id/invests(.:format)              invests#create			创建投资
               new_fund_invest GET        /funds/:fund_id/invests/new(.:format)          invests#new			投资的new页
                   edit_invest GET        /invests/:id/edit(.:format)                    invests#edit 			编辑投资
                        invest GET        /invests/:id(.:format)                         invests#show			投资的show页
                               PATCH      /invests/:id(.:format)                         invests#update			提交投资修改
                               PUT        /invests/:id(.:format)                         invests#update
                               DELETE     /invests/:id(.:format)                         invests#destroy		删除投资
                               GET        /users/:user_id/funds(.:format)                funds#index			用户的发标index页
                               POST       /users/:user_id/funds(.:format)                funds#create			用户提交新建发标
                 new_user_fund GET        /users/:user_id/funds/new(.:format)            funds#new			用户新建发标
                     edit_fund GET        /funds/:id/edit(.:format)                      funds#edit			编辑发标
                          fund GET        /funds/:id(.:format)                           funds#show			show发标
                               PATCH      /funds/:id(.:format)                           funds#update			提交发标更新
                               PUT        /funds/:id(.:format)                           funds#update
                               DELETE     /funds/:id(.:format)                           funds#destroy			删除发标
                          user GET        /users/:id(.:format)                           users#show			用户show页
                         funds GET        /funds(.:format)                               funds#index			发标的index页
                               POST       /funds(.:format)                               funds#create			提交新建发标
                      new_fund GET        /funds/new(.:format)                           funds#new			新建发标
                               GET        /funds/:id/edit(.:format)                      funds#edit			编辑发标
                               PATCH      /funds/:id(.:format)                           funds#update			提交编辑发标
                               PUT        /funds/:id(.:format)                           funds#update
                     leverages POST       /leverages(.:format)                           leverages#create		提交新建配资
                  new_leverage GET        /leverages/new(.:format)                       leverages#new			新建配资
                 edit_leverage GET        /leverages/:id/edit(.:format)                  leverages#edit			编辑配资
                      leverage GET        /leverages/:id(.:format)                       leverages#show			配资show页
                               PATCH      /leverages/:id(.:format)                       leverages#update		提交编辑配资
                               PUT        /leverages/:id(.:format)                       leverages#update
                         topic GET        /topics/:id(.:format)                          topics#show			话题的show页
```
