module Vagrant
  class Action
    module VM
      class ClearSharedFolders
        def initialize(app, env)
          @app = app
          @env = env
        end

        def call(env)
          env["config"].vm.customize do |vm|
            if vm.shared_folders.length > 0
              env.ui.info I18n.t("vagrant.actions.vm.clear_shared_folders.deleting")

              vm.shared_folders.dup.each do |shared_folder|
                shared_folder.destroy
              end
            end
          end

          @app.call(env)
        end
      end
    end
  end
end
