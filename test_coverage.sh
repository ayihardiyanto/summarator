set -e

find test/presentation -type d -name "*bloc*" -exec flutter test --coverage test/data/ test/domain {} \+
#
lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/env.dart'
lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/data/datasource/*'
# lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/presentation/screens/homepage/profile/icons/profile_icons_icons.dart'
# lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/presentation/screens/profile_data_employee/profile_data_employee_icons.dart'
# lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/presentation/screens/preboarding/preboarding_icons.dart'
# lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/common/injections/injector.dart'
# lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/common/injections/injector.iconfig.dart'
# lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/common/config/module_registrar.dart'
# lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/common/config/event_listener_registrar.dart'
# lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/presentation/screens/homepage/global_task/global_task_icons.dart'
# lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/presentation/widgets/showcase/*.dart'
# lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/common/constants/autolock_function.dart'
lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/common/*'
lcov --remove coverage/lcov.info -o coverage/lcov.info '*__mock__*'
# lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/presentation/screens/homepage/setting_icons_icons.dart'
# lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/presentation/screens/discover/reimbursement/submit_reimbursement/new_reimbursement/upload_reimbursement_document/upload_reimbursement_document_icons.dart'
# lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/presentation/screens/notification/notification_icons.dart'
# lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/presentation/screens/discover/reimbursement/submit_reimbursement/icons/office_suplies_icons.dart'
# lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/presentation/screens/discover/reimbursement/submit_reimbursement/icons/reimbursement_category_iconss.dart'
# lcov --remove coverage/lcov.info -o coverage/lcov.info 'lib/presentation/screens/discover/reimbursement/submit_reimbursement/icons/reimbursement_icon_icons.dart'
find lib/presentation -type f ! \( -name "*bloc.dart" -o -name "*state.dart" -o -name "*event.dart" \) -exec lcov --remove coverage/lcov.info -o coverage/lcov.info {} \+
lcov --list coverage/lcov.info
genhtml coverage/lcov.info --output=coverage
