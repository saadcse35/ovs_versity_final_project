package common

import com.amazonaws.services.s3.model.CannedAccessControlList
import com.amazonaws.services.s3.model.ObjectMetadata
import com.amazonaws.services.s3.model.PutObjectRequest
import org.springframework.web.multipart.MultipartFile


class FileUploadService {
    def amazonWebService
    def uploadImage(MultipartFile file, String name, String destinationFolder){
        def storagePath = "/opt/ovs/all_image/"+destinationFolder
        def storagePathDirectory = new File(storagePath)

        if(!storagePathDirectory.exists()){
            storagePathDirectory.mkdirs()
        }

        if(!file.isEmpty()){
            file.transferTo(new File("${storagePath}/${name}"))
            return "${storagePathDirectory}/${name}"
        }
        return null
    }

    def uploadFileToS3(MultipartFile multipartFile, String destinationFolder, def objectInstance, def propertyName){
        if(multipartFile && !multipartFile.empty) {
            def fileName = new Date().getTime() + multipartFile.originalFilename
            InputStream inputStream = multipartFile.getInputStream()

            Long size = multipartFile.getSize()
            String contentType = multipartFile.getContentType()
            ObjectMetadata metadata = new ObjectMetadata()
            metadata.setContentType(contentType)
            metadata.setContentLength(size)

            amazonWebService.s3.putObject(new PutObjectRequest('onlinevoting.com', "${destinationFolder}/" + fileName,
                    inputStream, metadata).withCannedAcl(CannedAccessControlList.PublicRead))
            // amazonS3Service.storeMultipartFile('rahmat24.com', 'news-main-images/'+ new Date().getTime() + multipartFile.originalFilename, multipartFile)

            objectInstance["${propertyName}"] =  "https://s3.amazonaws.com/onlinevoting" +
                    ".com/${destinationFolder}/" + fileName
        }
    }
}
