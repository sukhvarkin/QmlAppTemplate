file (GLOB TS_FILES
    ${CMAKE_CURRENT_LIST_DIR}/*.ts
)

# ******************************************
# Genarate QM files from TS
find_program(LRELEASE_EXECUTABLE NAMES lrelease-qt5 lrelease)

set(QM_FILES_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/i18n")
make_directory(${QM_FILES_DIRECTORY})

foreach (ts ${TS_FILES})
    get_filename_component(n "${ts}" NAME_WE)
    set(qm "${QM_FILES_DIRECTORY}/${n}.qm")
    list(APPEND QM_FILES ${qm})

    message(AAAA ${qm})

    add_custom_command (
        OUTPUT ${qm}
        COMMAND ${LRELEASE_EXECUTABLE} "${ts}" -qm ${qm}
        MAIN_DEPENDENCY ${ts}
    )
endforeach()


# ******************************************
# Create QRC file
set(TRANSLATINS_QRC_FILE "${CMAKE_CURRENT_BINARY_DIR}/i18n.qrc")

file(WRITE "${TRANSLATINS_QRC_FILE}" "")
file(APPEND "${TRANSLATINS_QRC_FILE}" "<!DOCTYPE RCC><RCC version=\"1.0\">\n")
file(APPEND "${TRANSLATINS_QRC_FILE}" "<qresource prefix=\"//\">\n")
foreach (qm  ${QM_FILES})
get_filename_component(qm_name "${qm}" NAME)
    file(APPEND "${TRANSLATINS_QRC_FILE}" "    <file>i18n/${qm_name}</file>\n")
endforeach()
file(APPEND "${TRANSLATINS_QRC_FILE}" "</qresource>\n")
file(APPEND "${TRANSLATINS_QRC_FILE}" "</RCC>\n")

