import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { ImageSnippet } from '../../entity/image-snippet';
import { AdminsService } from '../../services/admins.service';

@Component({
  selector: 'app-add-admins',
  templateUrl: './add-admins.component.html',
  styleUrls: ['./add-admins.component.scss']
})
export class AddAdminsComponent implements OnInit {
  allAdmins: any[];
  isSubmitted = false;
  uploadForm: FormGroup;
  uploadButtonValue = 'Upload';
  coverUploadButtonValue = 'Upload';
  imageName = 'Select Image';
  coverImageName = 'Select Cover Image';
  fileSelected = false;
  coverFileSelected = false;
  fileUploaded = false;
  imageReady = false;
  coverReady = false;
  imageUrl: string;
  coverImageUrl: string;
  imagePathReady = false;
  coverImagePathReady = false;
  submitButtonValue = 'Waiting Uploading Image';
  selectedFile: ImageSnippet;

  constructor(private adminService: AdminsService,
              private formBuilder: FormBuilder,
              private toaster: ToastrService,
              private router: Router,
              private activatedRoute: ActivatedRoute) {
  }

  ngOnInit() {


    // Fetch Form Data
    this.uploadForm = this.formBuilder.group({
      userID: ['', [Validators.required, Validators.email]],
      userName: ['', Validators.required],
      password: ['', Validators.required],
      location: [''],
      story: [''],
      image: [''],
      cover: ['']
    });
  }



  updateName(imageInput: any) {
    const file: File = imageInput.files[0];
    this.uploadButtonValue = 'Upload';
    this.imageName = file.name;
    this.fileSelected = true;
  }

  updateCoverName(imageInput: any) {
    const file: File = imageInput.files[0];
    this.coverUploadButtonValue = 'Upload';
    this.coverImageName = file.name;
    this.coverFileSelected = true;
  }

  processFile(imageInput: any) {
    this.imageReady = true;
    this.fileSelected = false;
    this.uploadButtonValue = 'Uploading...';
    console.log('Processing File');
    const file: File = imageInput.files[0];
    const reader = new FileReader();

    reader.addEventListener('load', (event: any) => {
      this.selectedFile = new ImageSnippet(event.target.result, file);
      this.adminService.uploadImage(this.selectedFile.file).subscribe(
        (res) => {
          console.log(res);
          this.imageUrl = res;
          this.imageReady = false;
          this.uploadButtonValue = 'Uploaded';
          this.imagePathReady = true;
          this.submitButtonValue = 'New Admin';
        },
        (err) => {
          console.log(err);
          this.imageReady = false;
        });
    });
    reader.readAsDataURL(file);
  }

  processCoverFile(imageInput: any) {
    this.coverReady = true;
    this.coverFileSelected = false;
    this.coverUploadButtonValue = 'Uploading...';
    console.log('Processing File');
    const file: File = imageInput.files[0];
    const reader = new FileReader();

    reader.addEventListener('load', (event: any) => {
      this.selectedFile = new ImageSnippet(event.target.result, file);
      this.adminService.uploadImage(this.selectedFile.file).subscribe(
        (res) => {
          console.log(res);
          this.coverImageUrl = res;
          this.coverReady = false;
          this.coverUploadButtonValue = 'Uploaded';
          this.coverImagePathReady = true;
          this.submitButtonValue = 'New Admin';
        },
        (err) => {
          console.log(err);
          this.coverReady = false;
        });
    });
    reader.readAsDataURL(file);
  }


  mySubmit() {
    this.isSubmitted = true;
    if (!this.uploadForm.valid) {
      this.toaster.error('Error : Form Not Valid');
      this.isSubmitted = false;
      return false;
    } else {
      // Fetch All Form Data On Json Type
      const formObject = this.uploadForm.getRawValue();
      // formObject.suggest = this.uploadForm.value.suggest == 1 ? true : false;
      formObject.image = this.imageUrl;
      formObject.cover = this.coverImageUrl;
      console.log(formObject);
      this.adminService.createAdmins(formObject).subscribe(
        (createResponse: any) => console.log(createResponse),
        error => {
          this.isSubmitted = false;
          console.log('Error : ', error);
        },
        () => {
          this.isSubmitted = false;
          this.router.navigate(['../'], {relativeTo: this.activatedRoute});
        }
      );
    }
  }

}
